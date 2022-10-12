import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:event_bus/event_bus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_huoshu_app/api/game_service.dart';
import 'package:flutter_huoshu_app/api/request_util.dart';
import 'package:flutter_huoshu_app/api/user_service.dart';
import 'package:flutter_huoshu_app/common/device_info/device_Info.dart';
import 'package:flutter_huoshu_app/common/style/color/huo_colors.dart';
import 'package:flutter_huoshu_app/common/style/huo_dimens.dart';
import 'package:flutter_huoshu_app/common/util/app_setting_util.dart';
import 'package:flutter_huoshu_app/common/util/app_util.dart';
import 'package:flutter_huoshu_app/common/util/login_util.dart';
import 'package:flutter_huoshu_app/component/video/event_bus_manager.dart';
import 'package:flutter_huoshu_app/event/event.dart';
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

import 'down_view_ios.dart';
import 'down_view_ios2.dart';

abstract class BaseDownView {}

const int TYPE_GAME_ITEM = 1;
const int TYPE_GAME_DETAILS = 2;

class DownView2 extends StatefulWidget {
  //传入一个game
  Game game;
  int type;

  //是否是预约
  bool isReserved = false;

  //是否是下载管理列表
  bool isFromDownloadManagerPage = false;

  DownView2({
    this.game,
    this.type,
    this.isReserved = false,
    this.isFromDownloadManagerPage = false,
  });

  @override
  State<StatefulWidget> createState() {
    print("createState type:$type");
    if (Platform.isIOS && game.classify == 4) {
      return NewDownState2(game, type);
    }
    return DownState(game, type, isReserved, isFromDownloadManagerPage);
  }
}

class DownState extends State<DownView2>
    implements BaseDownView, DownloadListener {
  //传入一个game
  Game game;
  int type;
  int status;
  double curProgress = 0;
  bool isDispose = false;

  //是否是预约
  bool isReserved = false;

  //是否是下载管理列表
  bool isFromDownloadManagerPage = false;

  DownState(
    this.game,
    this.type,
    this.isReserved,
    this.isFromDownloadManagerPage,
  );

  @override
  void initState() {
    print("DownState initstate");
    super.initState();
    isDispose = false;
    if (Platform.isAndroid) {
      queryStatus();
      //注册监听
      FlutterDownloadPlugin.registerCallback(this);
    }
  }

  @override
  void didUpdateWidget(DownView2 oldWidget) {
    print("DownState didUpdateWidget");
    super.didUpdateWidget(oldWidget);
    game = widget.game;
    type = widget.type;
    isDispose = false;
    if (Platform.isAndroid) {
      queryStatus();
      //注册监听
      FlutterDownloadPlugin.registerCallback(this);
    }
  }

  @override
  Widget build(BuildContext context) {
    String statusText = getText(name: 'textToDownload');
    Color bgColor = Colors.transparent;
    Color textColor = AppTheme.colors.themeColor;
    switch (status) {
      case DownloadStatus.INITIAL:
        statusText = getText(name: 'textToDownload');
        break;
      case DownloadStatus.DOWNLOADING:
        statusText = "${curProgress.toStringAsFixed(0)} %";
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
    if (type == TYPE_GAME_DETAILS) {
      return Container(
        margin: EdgeInsets.only(top: 10, bottom: 10, right: 30, left: 30),
        decoration: BoxDecoration(
            color: AppTheme.colors.themeColor,
            borderRadius: BorderRadius.all(Radius.circular(4))),
        child: MaterialButton(
          onPressed: () {
            onClick(context);
          },
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
          child: Material(
            color: bgColor,
            child: SizedBox(
              child: Center(
                child: Container(
                    height: HuoDimens.buttonheight1,
                    width: HuoDimens.buttonWidth1,
                    decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(HuoDimens.buttonRadius),
                        color: isReserved
                            ? Color(0xff666666)
                            : AppTheme.colors.themeColor),
                    child: Center(
                      child: Text(
                        game.classify == 5
                            ? getText(name: 'textToPlay')
                            : isReserved
                                ? getText(name: 'textReserved')
                                : statusText,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
//                            color: status == DownloadStatus.OPEN
//                                ? AppTheme.colors.textSubColor
//                                : AppTheme.colors.themeColor,
                            fontSize: 13),
                      ),
                    )),
              ),
            ),
          ),
        ),
      );
    }
  }

  void queryStatus() {
    //    查询状态(先查数据库)
    DownloadTask.getDownLoadTaskById(game.gameId).then((games) {
      if (isDispose) {
        return;
      }
      //默认跳转详情页，不处理下载按钮逻辑
      setState(() {
        this.status = DownloadStatus.INITIAL;
      });

      if (isFromDownloadManagerPage) {
        if (games.length > 0) {
          game.downUrl = games[0].downUrl;
          game.packageName = games[0].packageName;
          setState(() {
            this.status = DownloadStatus.INITIAL;
          });

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
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      print('Could not launch $url');
    }
  }

  //按钮的点击事件
  Future onClick(BuildContext context) async {
    //如果是预约游戏,不能下载
    if (widget.isReserved) {
      return;
    }
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
        AppUtil.gotoH5Game(context, game.downUrl, game.direction,
                gameName: game.gameName)
            .then((value) {
          EventBus eventBus = EventBusManager.getEventBus();
          eventBus.fire(RefreshH5Event("refreshH5", refresh: true));
        });
      });
    } else {
      if (!isFromDownloadManagerPage) {
        AppUtil.gotoGameDetailOrH5Game(context, game);
      } else {
        //根据状态触发不同状态
        //ios
        //Android
        print(status);
        if (Platform.isIOS) {
          _launchURL(game.downUrl);
          AppUtil.copyToClipboard(DeviceInfoUtil.iosSubCh);
          return;
        }

        switch (status) {
          case DownloadStatus.PAUSE:
            FlutterDownloadPlugin.startTask(
                game.gameName + ".apk", game.downUrl, game.gameId);
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
              showToast("当前设置非Wifi情况下不能下载  请前往设置页面设置");
            } else {
              GameService.getDownUrl(game.gameId).then((data) {
                //避免重复插入，先删除
                DownloadTask.deleteTaskByGame(game);
                DownloadTask.insert(DownloadTask.gameToDownloadTask(
                    game, data["data"]["down_url"], game.packageName));
                FlutterDownloadPlugin.startTask(game.gameName + ".apk",
                    data["data"]["down_url"], game.gameId);
              });
            }
            break;
          case DownloadStatus.DOWNLOADING: //暂停
            setState(() {
              status = DownloadStatus.PAUSE;
            });
            FlutterDownloadPlugin.pauseTask(
                game.gameName + ".apk", game.downUrl, game.gameId);
            break;

          case DownloadStatus.OPEN: //打开
            FlutterDownloadPlugin.open(game.packageName).then((isOpen) {
              if (!isOpen) {
                showToast("已卸载，请重新安装");
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
