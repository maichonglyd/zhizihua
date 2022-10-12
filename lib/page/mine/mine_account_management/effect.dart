import 'dart:io';

import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action, Page;
import 'package:flutter_huoshu_app/api/file_service.dart';
import 'package:flutter_huoshu_app/api/request_util.dart';
import 'package:flutter_huoshu_app/api/user_service.dart';
import 'package:flutter_huoshu_app/app_config.dart';
import 'package:flutter_huoshu_app/common/util/app_util.dart';
import 'package:flutter_huoshu_app/common/util/login_util.dart';
import 'package:flutter_huoshu_app/component/mine/mine_fragment_up/action.dart';
import 'package:flutter_huoshu_app/generated/l10n.dart';
import 'package:flutter_huoshu_app/generated/locale_manager.dart';
import 'package:flutter_huoshu_app/model/constant/H5Url.dart';
import 'package:flutter_huoshu_app/model/user/upload_info.dart';
import 'package:flutter_huoshu_app/model/user/user_info.dart';
import 'package:flutter_huoshu_app/page/mine/bind_mobile/page.dart';
import 'package:flutter_huoshu_app/page/mine/login/update_password/page.dart';
import 'package:flutter_huoshu_app/page/mine/update_mobile/page.dart';
import 'package:flutter_huoshu_app/page/web/page.dart';
import 'package:flutter_huoshu_app/page/web_plugin/page.dart';
import 'package:flutter_huoshu_app/utils/image_util.dart';
import 'package:flutter_huoshu_app/widget/dialog/UpdateNameDialog.dart';
import 'package:image_picker/image_picker.dart';
import 'package:oktoast/oktoast.dart';
import 'action.dart';
import 'state.dart';

Effect<AccountManageState> buildEffect() {
  return combineEffects(<Object, Effect<AccountManageState>>{
    AccountManageAction.action: _onAction,
    AccountManageAction.getUserInfo: _getUserInfo,
    AccountManageAction.gotoUpdatePw: _gotoUpdatePw,
    AccountManageAction.gotoWebView: _gotoWebView,
    AccountManageAction.gotoUpdateMobile: _gotoUpdateMobile,
    AccountManageAction.updateNickname: _updateNickname,
    AccountManageAction.selectPic: _selectPic,
    AccountManageAction.updateAvatar: _updateAvatar,
    AccountManageAction.gotoIdentify: _gotoIdentify,
    Lifecycle.initState: _init,
  });
}

void _onAction(Action action, Context<AccountManageState> ctx) {}

void _gotoIdentify(Action action, Context<AccountManageState> ctx) {
  UserInfo userInfo = LoginControl.getUserInfo();
  print("identifyUrl:${userInfo.data.identifyUrl.toString()}");
  if (userInfo != null && userInfo.data != null) {
    AppUtil.gotoH5Web(ctx.context, userInfo.data.identifyUrl, title: getText(name: 'textRealNameAuth'))
        .then((data) {
      //认证成功之后刷新页面
      ctx.broadcast(AccountManageActionCreator.getUserInfo());
      //通知个人中心更新
      ctx.broadcast(MineFragmentActionCreator.getUserInfo());
    });
  }
}

void _updateAvatar(Action action, Context<AccountManageState> ctx) {
  print("_updateAvatar:");
  UserService.updateAvatar(action.payload).then((data) {
    if (data['code'] == 200) {
      showToast(getText(name: 'toastChangeHeaderImg'));
      ctx.dispatch(AccountManageActionCreator.getUserInfo());
      //通知个人中心更新
      ctx.broadcast(MineFragmentActionCreator.getUserInfo());
    }
  }).catchError((err) {});
}

void _getUserInfo(Action action, Context<AccountManageState> ctx) {
  UserService.getUserInfo().then((UserInfo userInfo) {
    ctx.dispatch(AccountManageActionCreator.updateUserInfo(userInfo));
  }).catchError((err) {});
}

void _gotoUpdatePw(Action action, Context<AccountManageState> ctx) {
  AppUtil.gotoPageByName(ctx.context, UpdatePasswordPage.pageName);
}

void _gotoWebView(Action action, Context<AccountManageState> ctx) {
  int type = action.payload;
  String url;
  String title;
  switch (type) {
    case 1:
      title = getText(name: 'textUserAgreement');
      url = H5Url.url_agreement;
      break;
    case 2:
      title = getText(name: 'textParentalGuardianship');
      url = H5Url.url_Anti_fraud_instructions;
      break;
    case 3:
      title = getText(name: 'textAntiAddictionSystem');
      url = H5Url.url_Anti_addiction_system;
      break;
  }
  var pageName = WebPluginPage.pageName;
  if (Platform.isAndroid) {
    pageName = WebPage.pageName;
  }
  AppUtil.gotoPageByName(ctx.context, pageName,
      arguments: {"title": "$title", "url": url});
}

void _updateNickname(Action action, Context<AccountManageState> ctx) {
  //弹窗
  showDialog<Null>(
      context: ctx.context, //BuildContext对象
      barrierDismissible: false,
      builder: (BuildContext context) {
        return UpdateNameDialog(ctx.state.nicknameEditController, (name) {
          if (name.isNotEmpty) {
            UserService.updateNickname(name).then((data) {
              if (data['code'] == 200) {
                showToast(getText(name: 'textModifySuccessful'));
                Navigator.pop(context);
                //刷新界面
                ctx.dispatch(AccountManageActionCreator.getUserInfo());
                //通知个人中心更新
                ctx.broadcast(MineFragmentActionCreator.getUserInfo());
              }
            }).catchError((err) {
              showToast(getText(name: 'textModifySuccessful'));
            });
          } else {}
        });
      });
}

void _selectPic(Action action, Context<AccountManageState> ctx) {
  var image = ImagePicker.pickImage(source: ImageSource.gallery);
  image.then((file) {
    // 从图库选择照片后压缩图片，提升图片上传速度
    compressImageFile(file).then((compressFile) {
      //上传
      FileService.upload(compressFile).then((ImageUploadInfo data) {
        if (data.code == 200) {
          print("url123:" + data.data.url);
          ctx.dispatch(AccountManageActionCreator.updateAvatar(data.data.url));
        }
      });
    });
  });
}

void _gotoUpdateMobile(Action action, Context<AccountManageState> ctx) {
  AccountManageState state = ctx.state;
  //用户是否已经绑定isBind=2已绑定
  int isBind = action.payload;
  print("isBind: $isBind");
  if (isBind == 2) {
    AppUtil.gotoPageByName(ctx.context, UpdateMobilePage.pageName,
            arguments: state.userInfo.mobile)
        .then((data) {
      ctx.dispatch(AccountManageActionCreator.getUserInfo());
    });
  } else {
    AppUtil.gotoPageByName(ctx.context, BindMobilePage.pageName).then((data) {
      ctx.dispatch(AccountManageActionCreator.getUserInfo());
    });
  }
  //通知个人中心更新
  ctx.broadcast(MineFragmentActionCreator.getUserInfo());
}

void _init(Action action, Context<AccountManageState> ctx) {
  UserService.getUserInfo().then((UserInfo userInfo) {
    ctx.dispatch(AccountManageActionCreator.updateUserInfo(userInfo));
  }).catchError((err) {});
}
