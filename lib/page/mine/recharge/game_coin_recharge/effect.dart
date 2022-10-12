import 'dart:convert';

import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action, Page;
import 'package:flutter_huoshu_app/api/file_service.dart';
import 'package:flutter_huoshu_app/api/game_service.dart';
import 'package:flutter_huoshu_app/api/user_service.dart';
import 'package:flutter_huoshu_app/common/pay/pay.dart';
import 'package:flutter_huoshu_app/common/util/app_util.dart';
import 'package:flutter_huoshu_app/generated/l10n.dart';
import 'package:flutter_huoshu_app/generated/locale_manager.dart';
import 'package:flutter_huoshu_app/generated/theme/app_theme.dart';
import 'package:flutter_huoshu_app/model/user/upload_info.dart';
import 'package:flutter_huoshu_app/page/game_details_page/action.dart';
import 'package:flutter_huoshu_app/page/mine/mine_feedback/page.dart';
import 'package:flutter_huoshu_app/page/mine/recharge/game_coin_recharge_record/page.dart';
import 'package:flutter_huoshu_app/page/mine/recharge/game_coin_select_game/page.dart';
import 'package:flutter_huoshu_app/utils/coin_recharge_firstcome_util.dart';
import 'package:flutter_huoshu_app/utils/image_util.dart';
import 'package:flutter_huoshu_app/utils/order_to_pay.dart';
import 'package:flutter_huoshu_app/widget/huo_net_image.dart';
import 'package:image_picker/image_picker.dart';
import 'package:oktoast/oktoast.dart';
import 'package:url_launcher/url_launcher.dart';
import 'action.dart';
import 'state.dart';

Effect<GameCoinRechargeState> buildEffect() {
  return combineEffects(<Object, Effect<GameCoinRechargeState>>{
    GameCoinRechargeAction.action: _onAction,
    GameCoinRechargeAction.pay: _cpsPay,
    GameCoinRechargeAction.gotoSelectGame: _gotoSelectGame,
    GameCoinRechargeAction.gotoRecord: _gotoRecord,
    GameCoinRechargeAction.changeGame: _changeGame,
    GameCoinRechargeAction.gotoFeedback: _gotoFeedback,
    GameCoinRechargeAction.gotoRechargeInfo: _gotoRechargeInfo,
    GameCoinRechargeAction.selectPic: _selectPic,
    Lifecycle.initState: _init,
    Lifecycle.didChangeAppLifecycleState: _didChangeAppLifecycleState,
  });
}

//声明周期发生变化的时候刷新一下
void _didChangeAppLifecycleState(
    Action action, Context<GameCoinRechargeState> ctx) {
  var bool = ModalRoute.of(ctx.context).isCurrent;
  if (bool) {
//    if (ctx.state.dealPayInfoData != null) {
//      queryOrder(ctx.state.dealPayInfoData.data.orderId, ctx);
//    }
  }
}

void _onAction(Action action, Context<GameCoinRechargeState> ctx) {}

void _selectPic(Action action, Context<GameCoinRechargeState> ctx) {
  var image = ImagePicker.pickImage(source: ImageSource.gallery);
  image.then((file) {
    if (file != null) {
      compressImageFile(file).then((compressFile) {
        ctx.dispatch(GameCoinRechargeActionCreator.addPic(compressFile));
      });
    }
  });
}

void _changeGame(Action action, Context<GameCoinRechargeState> ctx) {
//  GameService.getGamesByGameName(ctx.state.game.gameName).then((data) {
  double itemHeight = 82;
  GameService.getCpsGame(1, ctx.state.gameId).then((data) {
    if (data.code == 200) {
      if (data.data.list != null && data.data.list.length > 0) {
        showModalBottomSheet(
            context: ctx.context,
            backgroundColor: Colors.transparent,
            builder: (context) {
              return Container(
                height: itemHeight * data.data.list.length + 47.5,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(10))),
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 47.5,
                      alignment: Alignment.centerLeft,
                      child: Text(
                        getText(name: 'textSelectRechargePlatform'),
                        style: TextStyle(
                          fontSize: 15,
                          color: AppTheme.colors.textColor,
                        ),
                      ),
                    ),
                    Expanded(
                        child: Container(
                      height: itemHeight * data.data.list.length,
                      child: ListView(
                        children: data.data.list.map((game) {
                          return game.cps != null
                              ? Container(
                                  height: 82,
                                  child: Row(
                                    children: <Widget>[
                                      Container(
                                        height: 50,
                                        width: 50,
                                        margin: EdgeInsets.only(right: 8),
                                        child: HuoNetImage(
//                                          imageUrl: game.cpsInfo.image,
                                          imageUrl: game.cps.cpsImage,
                                        ),
                                      ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: <Widget>[
                                            Text(game.cps.cpsName),
                                            Row(
                                              children: <Widget>[
                                                Image.asset(
                                                  "images/gm_pic_shou.png",
                                                  height: 15,
                                                  width: 15,
                                                ),
                                                Container(
                                                  child: Text(
                                                    "${game.rate * 10}${getText(name: 'textDiscount')}",
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        color:
                                                            Color(0xFFF35A58)),
                                                  ),
                                                ),
                                                Image.asset(
                                                  "images/gm_pic_xu.png",
                                                  height: 15,
                                                  width: 15,
                                                ),
                                                Container(
                                                  child: Text(
                                                    "${game.rate * 10}${getText(name: 'textDiscount')}",
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        color: AppTheme.colors
                                                            .textSubColor3),
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.maybePop(context);
                                          ctx.dispatch(
                                              GameCoinRechargeActionCreator
                                                  .updateGame(game));
                                          _getCpsAccountCheck(ctx);
                                        },
                                        child: Container(
                                          height: 30,
                                          width: 77,
                                          decoration: BoxDecoration(
                                              color: Color(0xFFFF842F),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20))),
                                          alignment: Alignment.center,
                                          child: Text(
                                            getText(name: 'textRechargeNow'),
                                            style: TextStyle(
                                                fontSize: 13,
                                                color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              width: 1,
                                              color: Color(0xffe5e5e5)))),
                                )
                              : Container();
                        }).toList(),
                      ),
                    )),
                  ],
                ),
              );
            });
      }
    } else {
      //更新err
      showToast(getText(name: 'toastGetFailed'));
    }
  });
}

void _init(Action action, Context<GameCoinRechargeState> ctx) {
  if (ctx.state.record != null) {
    ctx.state.accountController.text = (ctx.state.record.username);
    ctx.state.amountController.text =
        (ctx.state.record.money.toInt().toString());
    ctx.dispatch(GameCoinRechargeActionCreator.updateAmount(
        int.parse(ctx.state.record.money.toInt().toString())));
  }
  ctx.state.accountController.addListener(() {
    _getCpsAccountCheck(ctx);
  });
  ctx.state.amountController.addListener(() {
    ctx.dispatch(GameCoinRechargeActionCreator.updateAmount(int.parse(
        ctx.state.amountController.text != null &&
                ctx.state.amountController.text.isNotEmpty
            ? ctx.state.amountController.text
            : "0")));
  });
  _getCpsAccountCheck(ctx);
}

void _getCpsAccountCheck(Context<GameCoinRechargeState> ctx) {
  UserService.cpsAccountCheck(ctx.state.game.gameId, ctx.state.accountController.text, ctx.state.game.cpId).then((data) {
    if (200 == data.code) {
      ctx.dispatch(GameCoinRechargeActionCreator.updateRate(data.data.rate));
    }
  });
}

void _gotoRecord(Action action, Context<GameCoinRechargeState> ctx) {
  AppUtil.gotoPageByName(ctx.context, GameCoinRechargeRecordPage.pageName);
}

void _gotoSelectGame(Action action, Context<GameCoinRechargeState> ctx) {
  AppUtil.gotoPageByName(ctx.context, GameCoinSelectGamePage.pageName)
      .then((data) {
    ctx.dispatch(GameCoinRechargeActionCreator.updateGame(data));
    _getCpsAccountCheck(ctx);
  });
}

void _cpsPay(Action action, Context<GameCoinRechargeState> ctx) {
  if (ctx.state.game != null && ctx.state.game.isSdk == 1) {
    checkInfo(action, ctx);
    return;
  }

  String amountStr = ctx.state.amountController.text;
  String accountStr = ctx.state.accountController.text;
  if (amountStr.isEmpty || accountStr.isEmpty) {
    showToast(getText(name: 'textConfirmAccountAndRecharge'));
  }
  num amount = AppUtil.stringToNum(amountStr);

  if (amount > 0 && accountStr.isNotEmpty && ctx.state != null) {
    String orderPayWay = ctx.state.payType == 0 ? "alipay" : "wxpay";
    UserService.cpsPay(
      orderPayWay,
      amount,
      ctx.state.game.gameId.toString(),
      accountStr,
    ).then(((data) {
      orderToPay(ctx: ctx, data: data,);
    }));
  } else {
    showToast(getText(name: 'textConfirmAccountAndRecharge'));
  }
}

bool checkInfo(Action action, Context<GameCoinRechargeState> ctx) {
  String account = ctx.state.accountController.text;
  String amount = ctx.state.amountController.text;
  String password = ctx.state.pswController.text;
  String serverName = ctx.state.serverController.text;
  String roleName = ctx.state.roleNameController.text;
  String remark = ctx.state.remarkController.text;

  double amountDouble = double.parse(ctx.state.amountController.text == null
      ? "0"
      : ctx.state.amountController.text);

  if (account.isEmpty) {
    showToast(getText(name: 'toastCopyGameAccountNotNull'));
    return false;
  }

  if (amount.isEmpty) {
    showToast(getText(name: 'toastPriceNotNull'));
    return false;
  }

  if (amountDouble <= 0) {
    showToast(getText(name: 'toastPriceNotZero'));
    return false;
  }

  if (password.isEmpty) {
    showToast(getText(name: 'toastPasswordNotNull'));
    return false;
  }

  if (serverName.isEmpty) {
    showToast(getText(name: 'toastServiceNotNull'));
    return false;
  }

  if (roleName.isEmpty) {
    showToast(getText(name: 'toastRoleNotNull'));
    return false;
  }

  if (remark.isEmpty) {
    showToast(getText(name: 'toastRemarkNotNull'));
    return false;
  }

//  if (ctx.state.images.length <= 0) {
//    showToast("请上传图片");
//    return false;
//  }

  List<String> imageUrls = List();
  //上传图片
  FileService.uploadImageFiles(ctx.state.images).then((data) {
    print("======================上传图片:");
    print(data);
    print("======================上传图片:");
    for (ImageUploadInfo uploadInfo in data) {
      imageUrls.add(uploadInfo.data.filepath);
//      imageUrls.add( json.encode(uploadInfo.data.filepath));
    }
    String orderPayWay = ctx.state.payType == 0 ? "alipay" : "wxpay";
    UserService.cpsGamePay(
      orderPayWay,
      amountDouble,
      ctx.state.game.gameId.toString(),
      account,
      password,
      serverName,
      roleName,
      remark,
      json.encode(imageUrls),
    ).then(((data) {
      orderToPay(ctx: ctx, data: data, needPop: true);
    }));
  });

  return true;
}

void queryOrder(String orderId, Context<GameCoinRechargeState> ctx) {
  UserService.cpsQueryOrder(orderId).then((data) {
    if (data['code'] == 200 && data['data']['status'] == 2) {
      //支付成功
      showToast(getText(name: 'textPaySuccessful'));
//      Navigator.of(ctx.context).pop();
    } else {
      //支付失败
      showToast(getText(name: 'textPayFailed'));
    }
  });
}

void _gotoFeedback(Action action, Context<GameCoinRechargeState> ctx) {
  AppUtil.gotoPageByName(ctx.context, FeedbackPage.pageName, arguments: null);
}

void _gotoRechargeInfo(Action action, Context<GameCoinRechargeState> ctx) {}
