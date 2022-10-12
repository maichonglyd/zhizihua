import 'dart:convert';

import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action, Page;
import 'package:flutter_huoshu_app/api/common_dio.dart';
import 'package:flutter_huoshu_app/api/deal_service.dart';
import 'package:flutter_huoshu_app/common/util/app_util.dart';
import 'package:flutter_huoshu_app/generated/l10n.dart';
import 'package:flutter_huoshu_app/generated/locale_manager.dart';
import 'package:flutter_huoshu_app/model/deal/deal_prop_goods_list.dart';
import 'package:flutter_huoshu_app/model/deal/deal_prop_index_data.dart';
import 'package:flutter_huoshu_app/model/deal/deal_prop_role.dart';
import 'package:flutter_huoshu_app/model/deal/deal_prop_server.dart';
import 'package:flutter_huoshu_app/page/deal/prop_deal/prop_deal_buy_agree/page.dart';
import 'package:flutter_huoshu_app/page/deal/prop_deal/prop_deal_select_game/page.dart';
import 'package:flutter_huoshu_app/page/mine/account_recycle/account_recycle_success/page.dart';
import 'package:flutter_huoshu_app/utils/image_util.dart';
import 'package:image_picker/image_picker.dart';
import 'package:oktoast/oktoast.dart';
import 'action.dart';
import 'state.dart';

Effect<PropDealSellEditState> buildEffect() {
  return combineEffects(<Object, Effect<PropDealSellEditState>>{
    PropDealSellEditAction.action: _onAction,
    PropDealSellEditAction.selectPic: _selectPic,
    PropDealSellEditAction.showAgree: _showAgree,
    PropDealSellEditAction.gotoSelectGame: _gotoSelectGame,
    PropDealSellEditAction.selectServer: _selectServer,
    PropDealSellEditAction.selectRole: _selectRole,
    PropDealSellEditAction.getRoles: _getRoles,
    PropDealSellEditAction.commit: _commit,
    Lifecycle.initState: _init,
  });
}

void _onAction(Action action, Context<PropDealSellEditState> ctx) {}
void _init(Action action, Context<PropDealSellEditState> ctx) {
  if (ctx.state.goodsId != null) {
    DealService.getMaterialGoodsDetails(ctx.state.goodsId).then((data) {
      if (data.code == 200) {
        //设置text会触发改动监听，在reducer中不能分发action,只能在effect中设置
        ctx.state.priceController.text = data.data.price.toString();
        ctx.state.titleController.text = data.data.title;
        ctx.state.contentController.text = data.data.description;
        Goods goods = data.data;
        ctx.dispatch(PropDealSellEditActionCreator.echoDealDetails(goods));
      }
    });
  }

  ctx.state.priceController.addListener(() {
    String price = ctx.state.priceController.text;
    if (price.isNotEmpty) {
      ctx.dispatch(PropDealSellEditActionCreator.updateSellPrice(price));
    }
  });
}

void _commit(Action action, Context<PropDealSellEditState> ctx) {
  if (ctx.state.playedGame == null) {
    showToast(getText(name: 'toastPleaseSelectGame'));
    return;
  }
  if (ctx.state.curServer == null) {
    showToast(getText(name: 'toastPleaseSelectService'));
    return;
  }

  if (ctx.state.curRole == null) {
    showToast(getText(name: 'toastPleaseSelectRole'));
    return;
  }

  String price = ctx.state.priceController.text;

  if (price == null || price.isEmpty) {
    showToast(getText(name: 'toastInputPrice'));
    return;
  }

  if (double.parse(price) < ctx.state.minPrice) {
    showToast(getText(name: 'toastLowThanLowestPrice'));
    return;
  }
  String title = ctx.state.titleController.text;
  if (title == null || title.isEmpty) {
    showToast(getText(name: 'toastInputGoodsName'));
    return;
  }

  String content = ctx.state.contentController.text;
  if (content == null || content.isEmpty) {
    showToast(getText(name: 'toastInputDes'));
    return;
  }

  if (ctx.state.images.length <= 0) {
    showToast(getText(name: 'toastUploadImage'));
    return;
  }

  showDialog(
          context: ctx.context,
          builder: (context) {
            return PropDealBuyAgreePage().buildPage({
              "goodsId": ctx.state.goodsId,
              "gameId": ctx.state.playedGame.gameId,
              "serverId": ctx.state.curServer.serverId,
              "serverName": ctx.state.curServer.serverName,
              "roleId": ctx.state.curRole.roleId,
              "roleName": ctx.state.curRole.roleName,
              "price": price,
              "images": ctx.state.images,
              "title": title,
              "description": content,
            });
          },
          barrierDismissible: false)
      .then((result) {
    if (result != null && result == 1) {
      showToast(getText(name: 'toastOnShelfSuccessful'));
      Navigator.pop(ctx.context);
    }
  });
}

void _getRoles(Action action, Context<PropDealSellEditState> ctx) {
  DealService.getMaterialRoles(
          ctx.state.playedGame.gameId, ctx.state.curServer.serverId)
      .then((data) {
    if (data.code == CommonDio.SUCCESS_CODE) {
      ctx.dispatch(PropDealSellEditActionCreator.updateRoles(data.data.list));
    }
  });
}

void _selectRole(Action action, Context<PropDealSellEditState> ctx) {
  String roleName = action.payload;
  for (Role role in ctx.state.roles) {
    if (role.roleName == roleName) {
      ctx.dispatch(PropDealSellEditActionCreator.updateCurRole(role));
      break;
    }
  }
}

void _selectServer(Action action, Context<PropDealSellEditState> ctx) {
  String serverName = action.payload;
  print("_selectServer--serverName: $serverName");
  for (Service service in ctx.state.services) {
    if (service.serverName == serverName) {
      print("service.serverName: ${service.serverName}");
      ctx.dispatch(PropDealSellEditActionCreator.updateCurServer(service));
      ctx.dispatch(PropDealSellEditActionCreator.getRoles());
      break;
    }
  }
}

void _gotoSelectGame(Action action, Context<PropDealSellEditState> ctx) {
  AppUtil.gotoPageByName(ctx.context, PropDealSelectGamePage.pageName,
      arguments: {"is_mine": 2}).then((playedGame) {
    //标识已经选择游戏
    //刷新界面
    if (playedGame != null) {
      ctx.dispatch(PropDealSellEditActionCreator.updateGame(playedGame));
      var game = playedGame as PlayedGame;
      //请求区服列表
      DealService.getMaterialServicesByMine(game.gameId, 1).then((data) {
        if (data.code == CommonDio.SUCCESS_CODE) {
          ctx.dispatch(
              PropDealSellEditActionCreator.updateServices(data.data.list));
        }
      });
    }
  });
}

void _showAgree(Action action, Context<PropDealSellEditState> ctx) {}

void _selectPic(Action action, Context<PropDealSellEditState> ctx) {
  var image = ImagePicker.pickImage(source: ImageSource.gallery);
  image.then((file) {
    if (file != null) {
      // 从图库选择照片后压缩图片，提升图片上传速度
      compressImageFile(file).then((compressFile) {
        ctx.dispatch(PropDealSellEditActionCreator.addPic(compressFile));
      });
    }
  });
}
