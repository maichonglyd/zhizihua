import 'dart:convert';

import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:flutter_huoshu_app/api/common_dio.dart';
import 'package:flutter_huoshu_app/api/deal_service.dart';
import 'package:flutter_huoshu_app/api/file_service.dart';
import 'package:flutter_huoshu_app/api/loading_dialog/page.dart';
import 'package:flutter_huoshu_app/component/deal/prop_deal/prop_deal_fragment/action.dart';
import 'package:flutter_huoshu_app/generated/l10n.dart';
import 'package:flutter_huoshu_app/generated/locale_manager.dart';
import 'package:flutter_huoshu_app/model/user/upload_info.dart';
import 'package:oktoast/oktoast.dart';
import 'action.dart';
import 'state.dart';

Effect<PropDealBuyAgreeState> buildEffect() {
  return combineEffects(<Object, Effect<PropDealBuyAgreeState>>{
    PropDealBuyAgreeAction.action: _onAction,
    PropDealBuyAgreeAction.commit: _commit,
  });
}

void _onAction(Action action, Context<PropDealBuyAgreeState> ctx) {}

void _commit(Action action, Context<PropDealBuyAgreeState> ctx) {
  String mobile = ctx.state.mobileController.text;
  if (mobile == null || mobile.isEmpty) {
    showToast(getText(name: 'textInputPhone'));
    return;
  }

  String password = ctx.state.passwordController.text;
  if (password == null || password.isEmpty) {
    showToast(getText(name: 'textInputPassword'));
    return;
  }
  submitData(ctx, mobile, password);
}

void submitData(
    Context<PropDealBuyAgreeState> ctx, String mobile, String password) {
  //做好等待提示
  showDialog(
      context: ctx.context,
      builder: (context) {
        return new WillPopScope(
          onWillPop: () {
            return Future.value(true);
          },
          child: new LoadingDialogPage().buildPage(null),
        );
      },
      barrierDismissible: false);

  List<String> imageUrls = List();
  //上传图片
  FileService.uploadImageFiles(ctx.state.images).then((data) {
    Navigator.pop(ctx.context);

    for (ImageUploadInfo uploadInfo in data) {
      imageUrls.add(uploadInfo.data.url);
    }
    if (ctx.state.goodsId == null) {
      //请求出售接口
      DealService.sellMaterialGoods(ctx.state.gameId,
              serverId: ctx.state.serverId,
              serverName: ctx.state.serverName,
              roleId: ctx.state.roleId,
              roleName: ctx.state.roleName,
              price: ctx.state.price,
              title: ctx.state.title,
              password: password,
              imageJson: json.encode(imageUrls),
              description: ctx.state.description,
              mobile: mobile,
              ctx: ctx)
          .then((data) {
        if (data.code == CommonDio.SUCCESS_CODE) {
          ctx.broadcast(PropDealFragmentActionCreator.getIndexData());
          Navigator.pop(ctx.context, 1);
        }
      });
    } else {
      print("商品上架修改");
      DealService.editMaterialGoods(ctx.state.goodsId,
              serverId: ctx.state.serverId,
              serverName: ctx.state.serverName,
              roleId: ctx.state.roleId,
              roleName: ctx.state.roleName,
              price: ctx.state.price,
              title: ctx.state.title,
              password: password,
              imageJson: json.encode(imageUrls),
              description: ctx.state.description,
              mobile: mobile,
              ctx: ctx)
          .then((data) {
        if (data.code == CommonDio.SUCCESS_CODE) {
          ctx.broadcast(PropDealFragmentActionCreator.getIndexData());
          Navigator.pop(ctx.context, 1);
        }
      });
    }
  }).catchError((data) {
    Navigator.pop(ctx.context);
  });
}
