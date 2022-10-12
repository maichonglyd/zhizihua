import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_huoshu_app/api/game_service.dart';
import 'package:flutter_huoshu_app/api/user_service.dart';
import 'package:flutter_huoshu_app/common/device_info/device_Info.dart';
import 'package:flutter_huoshu_app/common/style/huo_dimens.dart';
import 'package:flutter_huoshu_app/common/util/app_util.dart';
import 'package:flutter_huoshu_app/common/util/huo_log.dart';
import 'package:flutter_huoshu_app/common/util/login_util.dart';
import 'package:flutter_huoshu_app/generated/l10n.dart';
import 'package:flutter_huoshu_app/generated/locale_manager.dart';
import 'package:flutter_huoshu_app/generated/theme/app_theme.dart';
import 'package:flutter_huoshu_app/model/game/game_bean.dart';
import 'package:flutter_huoshu_app/model/user/user_info.dart';
import 'package:flutter_huoshu_app/page/mine/login/login_page/page.dart';
import 'package:flutter_huoshu_app/plugin/download_sign/download_sign_manager.dart';
import 'package:flutter_huoshu_app/plugin/download_sign/model/download_sign_task_model.dart';
import 'package:flutter_huoshu_app/plugin/download_sign/task/down_sign_task_interface.dart';
import 'package:flutter_huoshu_app/utils/debounce_throttle.dart';
import 'package:oktoast/oktoast.dart';
import 'package:url_launcher/url_launcher.dart';

import 'down_view.dart';

abstract class BaseDownView {}

const int TYPE_GAME_ITEM = 1;
const int TYPE_GAME_DETAILS = 2;
const int TYPE_GAME_DETAILS_DIALOG = 3;
const int TYPE_GAME_DETAILS_DIALOG2 = 4;

typedef CallbackNull = void Function();
typedef Callback<T> = void Function(T t);

class NewDownState extends State<DownView>
    implements BaseDownView, DownloadSignListener {
  //传入一个game
  Game game;
  int type;

  NewDownState(this.game, this.type);

  int status = DownSignTaskStatus.initial;
  double curProgress = 0;
  bool isDispose = false;

  @override
  void initState() {
    print("DownState initstate");
    super.initState();
    isDispose = false;
    DownloadSignManager.addListener(this).then((value) {
      if (mounted && !isDispose && value != null) {
        setState(() {
          status = value.status;
          curProgress = value.progress;
        });
      }
    });
  }

  @override
  void didUpdateWidget(DownView oldWidget) {
    print("DownState didUpdateWidget");
    super.didUpdateWidget(oldWidget);
    game = widget.game;
    type = widget.type;
    isDispose = false;
  }

  @override
  Widget build(BuildContext context) {
    String statusText = getText(name: 'textToDownload');
    Color bgColor = Colors.transparent;
    Color textColor = AppTheme.colors.themeColor;
    switch (status) {
      case DownSignTaskStatus.initial:
        statusText = getText(name: 'textToDownload');
        break;
      case DownSignTaskStatus.enqueued:
      case DownSignTaskStatus.running:
        statusText = "${curProgress.toStringAsFixed(2)} %";
        bgColor = AppTheme.colors.themeColor;
        textColor = Colors.white;
        break;
      case DownSignTaskStatus.pause:
        statusText = getText(name: 'textContinue');
        break;
      case DownSignTaskStatus.success:
        //安卓可能是打开 todo by liuhongliang
        statusText = getText(name: 'textInstall');
        break;
      case DownSignTaskStatus.installed:
        if (type == TYPE_GAME_DETAILS_DIALOG) {
          statusText = getText(name: 'textEnjoyNow');
        } else {
          if (Platform.isIOS) {
            statusText = getText(name: 'textToDownload');
          } else {
            statusText = getText(name: 'textOpen');
          }
        }
        break;
      case DownSignTaskStatus.error:
        statusText = getText(name: 'textRetry');
        break;
    }

    if (type == TYPE_GAME_DETAILS_DIALOG) {
      return GestureDetector(
        onTap: () {
          onClick(context);
        },
        child: Container(
          width: 111,
          height: 41,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: AppTheme.colors.themeColor,
              borderRadius: BorderRadius.all(Radius.circular(21))),
          child: Text(
            "$statusText",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontSize: 14),
          ),
        ),
      );
    } else if (type == TYPE_GAME_DETAILS_DIALOG2) {
      return GestureDetector(
        onTap: () {
          debounce(() {
            onClick(context);
          }, Duration(seconds: 1));
        },
        child: Container(
          width: 111,
          height: 41,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: AppTheme.colors.themeColor,
              borderRadius: BorderRadius.all(Radius.circular(21))),
          child: Text(
            "$statusText",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontSize: 14),
          ),
        ),
      );
    } else if (type == TYPE_GAME_DETAILS) {
      return GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          onClick(context);
        },
        child: Container(
          width: double.infinity,
          height: double.infinity,
          alignment: Alignment.center,
          child: Text(
            "${game.classify == 5 ? getText(name: 'textOpenPlay') : statusText + "(${game.size})"}",
            style: TextStyle(color: Colors.white),
          ),
        ),
      );
    } else {
      return GestureDetector(
          onTap: () {
            onClick(context);
          },
          child: Container(
            alignment: Alignment.center,
            height: 27,
            width: 55,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(HuoDimens.buttonRadius),
                color: AppTheme.colors.themeColor),
//            decoration: BoxDecoration(
//                gradient: LinearGradient(colors: [
//                  Color(0xffFF5D45),
//                  Color(0xffFF9356),
//                ]),
//                borderRadius: BorderRadius.all(Radius.circular(15))),

            child: Text(
              game.classify == 5 ? getText(name: 'textToPlay') : statusText,
              style: TextStyle(color: Colors.white, fontSize: 13),
            ),
          ));
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    isDispose = true;
    print("dispose ${game.gameName.toString()}");
    DownloadSignManager.removeListener(this);
  }

  _launchURL(String url) async {
//    url="itms-services://?action=download-manifest&url=https://dios.tstjgame.com/sdkgame/jzfhlios_6109/jzfhlios_6109.plist";
    print("准备打开的游戏地址为：" + url);
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      print('Could not launch $url');
    }
  }

  //按钮的点击事件
  Future onClick(BuildContext context) async {
    print("click:" +
        game.gameId.toString() +
        "type $type  widget.type:${widget.type}");
    print("click:" +
        game.gameId.toString() +
        "type $type  widget.type:${widget.type}");

    if (game.classify == 5 && type != TYPE_GAME_DETAILS_DIALOG) {
      //H5游戏 打开网页
      if (!LoginControl.isLogin()) {
        AppUtil.gotoPageByName(context, LoginPage.pageName);
        return;
      }
      UserService.getUserInfo().then((UserInfo userInfo) {
        AppUtil.gotoH5Game(context, game.downUrl, game.direction,
            gameName: game.gameName);
      });
    } else {
      DownloadSignManager.click(game, 1);
    }
  }

  @override
  void onCompleted() {
    if (mounted && !isDispose) {
      setState(() {
        status = DownSignTaskStatus.success;
      });
    }
  }

  @override
  void onError() {
    if (mounted && !isDispose) {
      setState(() {
        status = DownSignTaskStatus.error;
      });
    }
  }

  @override
  int onGetGameId() {
    return game.gameId;
  }

  @override
  void onInstalled() {
    if (mounted && !isDispose) {
      setState(() {
        status = DownSignTaskStatus.installed;
      });
    }
  }

  @override
  void onPause(String msg) {
    if (mounted && !isDispose) {
      setState(() {
        status = DownSignTaskStatus.pause;
      });
    }
  }

  @override
  void onUpdate() {}

  @override
  void onProgress(double progress, String speed) {
    if (mounted && !isDispose) {
      setState(() {
        status = DownSignTaskStatus.running;
        curProgress = progress;
      });
    }
  }

  @override
  bool onShowHint(int clickId, Object tag, next) {}
}
