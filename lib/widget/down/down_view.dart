import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_huoshu_app/api/game_service.dart';
import 'package:flutter_huoshu_app/api/request_util.dart';
import 'package:flutter_huoshu_app/api/user_service.dart';
import 'package:flutter_huoshu_app/common/device_info/device_Info.dart';
import 'package:flutter_huoshu_app/common/style/huo_dimens.dart';
import 'package:flutter_huoshu_app/common/util/app_setting_util.dart';
import 'package:flutter_huoshu_app/common/util/app_util.dart';
import 'package:flutter_huoshu_app/common/util/login_util.dart';
import 'package:flutter_huoshu_app/generated/l10n.dart';
import 'package:flutter_huoshu_app/generated/locale_manager.dart';
import 'package:flutter_huoshu_app/generated/theme/app_theme.dart';
import 'package:flutter_huoshu_app/model/game/game_bean.dart';
import 'package:flutter_huoshu_app/model/game/game_details.dart'
    as game_details;
import 'package:flutter_huoshu_app/model/user/user_info.dart';
import 'package:flutter_huoshu_app/page/mine/login/login_page/page.dart';
import 'package:flutter_huoshu_app/page/web/page.dart';
import 'package:flutter_huoshu_app/repository/game_download_repository.dart';

import 'package:flutter_huoshu_app/plugin/flutter_download_plugin.dart';
import 'package:oktoast/oktoast.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../common/util/huo_log.dart';
import 'down_view_ios.dart';

abstract class BaseDownView {}

const int TYPE_GAME_ITEM = 1;
const int TYPE_GAME_DETAILS = 2;
const int TYPE_GAME_DETAILS_DIALOG = 3;

class DownView extends StatefulWidget {
  //传入一个game
  Game game;
  int type;

  DownView({this.game, this.type});

  @override
  State<StatefulWidget> createState() {
    print("createState type:$type");
    if (Platform.isIOS && game.classify == 4) {
      return NewDownState(game, type);
    }
    return DownState(game, type);
  }
}

class IosDownState extends State<DownView> implements BaseDownView {
  //传入一个game
  Game game;
  int type;

  IosDownState(this.game, this.type);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}

class DownState extends State<DownView>
    implements BaseDownView, DownloadListener {
  //传入一个game
  Game game;
  int type;

  DownState(this.game, this.type);

  int status;
  double curProgress = 0;
  bool isDispose = false;

  @override
  void initState() {
    print("DownState initstate");
    super.initState();
    isDispose = false;
//    if (Platform.isAndroid) {
    queryStatus();
    //注册监听
    FlutterDownloadPlugin.registerCallback(this);
//    }
  }

  @override
  void didUpdateWidget(DownView oldWidget) {
    print("DownState didUpdateWidget");
    super.didUpdateWidget(oldWidget);
    game = widget.game;
    type = widget.type;
    isDispose = false;
//    if (Platform.isAndroid) {
    queryStatus();
    //注册监听
    FlutterDownloadPlugin.registerCallback(this);
//    }
  }

  @override
  Widget build(BuildContext context) {
    String statusText = getText(name: 'textToDownload');
    Color bgColor = Colors.transparent;
    Color textColor = AppTheme.colors.themeColor;
    switch (status) {
      case DownloadStatus.INITIAL:
        statusText =  getText(name: 'textToDownload');
        break;
      case DownloadStatus.DOWNLOADING:
        if (Platform.isIOS) {
          statusText = getText(name: 'textProcessing');
          bgColor = AppTheme.colors.themeColor;
          textColor = Colors.white;
        } else {
          statusText = "${curProgress.toStringAsFixed(1)} %";
          bgColor = AppTheme.colors.themeColor;
          textColor = Colors.white;
        }
        break;
      case DownloadStatus.PAUSE:
        statusText = getText(name: 'textContinue');
        break;
      case DownloadStatus.INSTALL:
        statusText = getText(name: 'textInstall');
        break;
      case DownloadStatus.OPEN:
        statusText = getText(name: 'textOpen');
        break;
      case DownloadStatus.RETRY:
        statusText = getText(name: 'textRetry');
        break;
    }

    if (type == TYPE_GAME_DETAILS_DIALOG) {
      return Container(
          alignment: Alignment.center,
          child: GestureDetector(
            onTap: () {
              onClick(context);
            },
            child: Text(
              "${statusText}",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 14),
            ),
          ));
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
            child: Text(
              game.classify == 5 ? getText(name: 'textToPlay') : statusText,
              style: TextStyle(color: Colors.white, fontSize: 13),
            ),
          ));
    }
  }

  void queryStatus() {
    if (Platform.isIOS) {
      FlutterDownloadPlugin.getStatus(
              game.gameName + ".apk", game.downUrl, game)
          .then((status) {
        setState(() {
          this.status = status;
        });
      });
      return;
    }

    //    查询状态(先查数据库)
    DownloadTask.getDownLoadTaskById(game.gameId).then((games) {
      if (isDispose) {
        return;
      }
      if (games.length > 0) {
        game.downUrl = games[0].downUrl;
        game.packageName = games[0].packageName;

        if (games[0].install == 1) {
          setState(() {
            this.status = DownloadStatus.OPEN;
          });
          return;
        }
        FlutterDownloadPlugin.getStatus(
                game.gameName + ".apk", game.downUrl, game)
            .then((status) {
          setState(() {
            this.status = status;
          });
        });
      } else {
        setState(() {
          this.status = DownloadStatus.INITIAL;
        });
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    isDispose = true;
    print("dispose ${game.gameName.toString()}");
    if (Platform.isAndroid) {
      FlutterDownloadPlugin.unRegisterCallback(this);
    }
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

    if (game.classify == 5) {
      //H5游戏 打开网页
      if (!LoginControl.isLogin()) {
        AppUtil.gotoPageByName(context, LoginPage.pageName);
        return;
      }
      UserService.getUserInfo().then((UserInfo userInfo) {
        // AppUtil.gotoH5Game(context, game.downUrl, gameName: game.gameName);
        AppUtil.gotoH5Game(context, game.downUrl, game.direction,
            gameName: game.gameName);
      });
    } else {
      //根据状态触发不同状态
      //ios
      //Android
      print(status);
//      if (Platform.isIOS && DeviceInfoUtil.deviceBean.mac.isNotEmpty) {
//        game.downUrl = RequestUtil.urlAppendCommonParams(game.downUrl);
//        game.downUrl += "&udid=" + DeviceInfoUtil.deviceBean.mac;
//
//        _launchURL(game.downUrl + "?");
//        AppUtil.copyToClipboard(DeviceInfoUtil.iosSubCh);
//
//        return;
//      }

      switch (status) {
        case DownloadStatus.PAUSE:
        //判断是否在wifi下和wifi设置才下载
          Connectivity connectivity = new Connectivity();
          ConnectivityResult connectivityResult =
          await connectivity.checkConnectivity();
          if (!AppSetUtil.getValue(AppSetUtil.KEY_IS_4G_DOWN, true) &&
              connectivityResult == ConnectivityResult.mobile) {
            // 不允许4g下载&&当前是4G环境
            //提示前往设置页面
            showToast(getText(name: 'textNotWifiNotDownload'));
          } else {
            FlutterDownloadPlugin.startTask(
                game.gameName + ".apk", game.downUrl, game.gameId);
          }
          break;
        case DownloadStatus.RETRY:
        case DownloadStatus.INITIAL:
          //判断是否在wifi下和wifi设置才下载
          Connectivity connectivity = new Connectivity();
          ConnectivityResult connectivityResult =
              await connectivity.checkConnectivity();
          if (!AppSetUtil.getValue(AppSetUtil.KEY_IS_4G_DOWN, true) &&
              connectivityResult == ConnectivityResult.mobile) {
            // 不允许4g下载&&当前是4G环境
            //提示前往设置页面
            showToast(getText(name: 'textNotWifiNotDownload'));
          } else {
//            DeviceInfoUtil.deviceBean.mac =
//                "3edbe151f1aab87a2f26b67b30bad73b897d1dasd909";
            print(
                "click@@@@@:${game.gameId.toString()}  udid:${DeviceInfoUtil.deviceBean.mac}");
            //ios下载接口很慢，先显示处理中
            if (Platform.isIOS) {
              setState(() {
                status = DownloadStatus.DOWNLOADING;
              });
            }

            GameService.getDownUrl(game.gameId,
                    udid: DeviceInfoUtil.deviceBean.mac, isShowToast: false)
                .then((data) {
              if (Platform.isAndroid) {
                //避免重复插入，先删除
                DownloadTask.deleteTaskByGame(game);
                DownloadTask.insert(DownloadTask.gameToDownloadTask(
                    game, data["data"]["down_url"], game.packageName));
                FlutterDownloadPlugin.startTask(game.gameName + ".apk",
                    data["data"]["down_url"], game.gameId);
              } else {
                //避免重复插入，先删除
//                DownloadTask.deleteTaskByGame(game);
//                DownloadTask.insert(DownloadTask.gameToDownloadTask(
//                    game, data["data"]["down_url"], game.packageName));

                if (data['code'] != 55013 && data['code'] != 200) {
                  showToast("${getText(name: 'textDownloadFailed')}${data['code']}");
                  setState(() {
                    status = DownloadStatus.INITIAL;
                  });
                } else {
                  String downUrl = "";
                  if (data["data"] != null &&
                      data["data"]["down_url"] != null) {
                    downUrl = data["data"]["down_url"];

                    if (data["data"]["is_web"] != null &&
                        data["data"]["is_web"].toString() == "2") {
                      try {
                        HuoLog.d("downUrl = $downUrl");
                        launch(downUrl);
                      } catch (e) {
                        print(e);
                      }
                      return;
                    }
                  }

                  FlutterDownloadPlugin.startTask(
                      game.gameName + ".apk", downUrl, game.gameId);
                }
              }
            });
          }
          break;
        case DownloadStatus.DOWNLOADING: //暂停
          if (!Platform.isIOS) {
            setState(() {
              status = DownloadStatus.PAUSE;
            });
            FlutterDownloadPlugin.pauseTask(
                game.gameName + ".apk", game.downUrl, game.gameId);
          }
          break;

        case DownloadStatus.OPEN: //打开
          FlutterDownloadPlugin.open(game.packageName).then((isOpen) {
            if (!isOpen) {
              showToast(getText(name: 'textUninstalled'));
              //打不开了，卸载了，变为未安装：
              DownloadTask.updateDownLoadTaskInstall(game.packageName, 0);
              queryStatus();
            }
          });
          break;
        case DownloadStatus.INSTALL: //安装
          FlutterDownloadPlugin.install(game.gameName + ".apk", game.downUrl);
          break;
      }
    }
  }

  @override
  void canceled() {}

  @override
  void completed() {
    setState(() {
      status = DownloadStatus.INSTALL;
    });
  }

  @override
  void connected() {
    // TODO: implement connected
  }

  @override
  void error() {
    print("downview:error");
    showToast(getText(name: 'textDownloadError'));
    setState(() {
      status = DownloadStatus.RETRY;
    });
  }

  @override
  void progress(currentOffset, totalLength) {
    setState(() {
      status = DownloadStatus.DOWNLOADING;
      curProgress = (currentOffset / totalLength) * 100;
      if (type == 2) print("=-==-=-===type:$type  curProgress:$curProgress");
    });
  }

  @override
  void retry() {
    // TODO: implement retry
  }

  @override
  void started() {
    // TODO: implement started
  }

  @override
  void warn() {
    // TODO: implement warn
  }

  @override
  int getGameId() {
    return widget.game.gameId;
  }

  @override
  void update() {
    //获取状态，更新控件
    queryStatus();
  }
}
