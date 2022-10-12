import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_huoshu_app/app_config.dart';
import 'package:flutter_huoshu_app/generated/l10n.dart';
import 'package:flutter_huoshu_app/generated/locale_manager.dart';
import 'package:flutter_huoshu_app/generated/theme/app_theme.dart';
import 'package:flutter_huoshu_app/model/init/init_info.dart';
import 'package:flutter_huoshu_app/plugin/download_sign/download_sign_manager.dart';
import 'package:flutter_huoshu_app/plugin/flutter_download_plugin.dart';
import 'package:url_launcher/url_launcher.dart';

class UpdateAppDialog extends StatefulWidget {
  UpInfo upInfo;
  Function() cancelFun;

  UpdateAppDialog({
    Key key,
    @required this.upInfo,
    this.cancelFun,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return UpdateAppState();
  }
}

class UpdateAppState extends State<UpdateAppDialog> {
  int status = DownloadStatus.INITIAL;
  double curProgress = 0;
  UpdateDownListener updateDownListener;

  UpdateAppState();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (Platform.isAndroid) {
      updateDownListener = new UpdateDownListener((status, progress) {
        updateStatus(status, progress);
      });
      FlutterDownloadPlugin.registerCallback(updateDownListener);
    } else {
      DownloadSignManager.addListener(
          new UpdateDownloadSign((status, progress) {
        updateStatus(status, progress);
      }));
    }
  }

  void updateStatus(int status, double progress) {
    this.status = status;
    curProgress = progress;
    setState(() {});
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    if (Platform.isAndroid) {
      FlutterDownloadPlugin.unRegisterCallback(updateDownListener);
    }
  }

  @override
  Widget build(BuildContext context) {
    String statusText = getText(name: 'textToDownload');
    switch (status) {
      case DownloadStatus.INITIAL:
        statusText = getText(name: 'textToDownload');
        break;
      case DownloadStatus.DOWNLOADING:
        statusText = "${curProgress.toStringAsFixed(1)} %";
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
      case DownloadStatus.REQUEST:
        statusText = getText(name: 'textDownloadRequest');
        break;
    }
    return AnimatedPadding(
        padding: MediaQuery.of(context).viewInsets +
            const EdgeInsets.symmetric(horizontal: 40.0, vertical: 24.0),
        duration: Duration(milliseconds: 100),
        curve: Curves.decelerate,
        child: MediaQuery.removeViewInsets(
          removeLeft: true,
          removeTop: true,
          removeRight: true,
          removeBottom: true,
          context: context,
          child: Center(
              child: Stack(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 126),
                width: 271,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(15),
                        bottomRight: Radius.circular(15)),
                    color: Colors.white),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(top: 49),
                      child: Text(
                        getText(name: 'textUpdateVersion') +
                                widget.upInfo.version ??
                            "",
                        maxLines: 1,
                        style: TextStyle(
                            color: AppTheme.colors.textColor,
                            fontSize: 17,
                            decoration: TextDecoration.none),
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(top: 19, left: 17, right: 17),
                      child: Text(
                        widget.upInfo.content,
                        maxLines: 3,
                        style: TextStyle(
                            color: AppTheme.colors.textSubColor,
                            fontSize: 13,
                            decoration: TextDecoration.none),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        if (widget.upInfo.upStatus == 2)
                          GestureDetector(
                            onTap: () {
                              if (Platform.isIOS) {
                                DownloadSignManager.deleteDownSignTaskByAppid(
                                    int.parse(AppConfig.iosAppid));
                              }
                              if (null != widget.cancelFun) {
                                widget.cancelFun();
                              }
                              Navigator.pop(context);
                            },
                            child: Container(
                              margin: EdgeInsets.only(top: 25, bottom: 18),
                              height: 41,
                              width: 111,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(21)),
                                  border: Border.all(color: Color(0xffd8d8d8))),
                              child: Text(
                                getText(name: 'textCancel'),
                                style: TextStyle(
                                    fontSize: 16,
                                    color: AppTheme.colors.textSubColor2,
                                    decoration: TextDecoration.none),
                              ),
                            ),
                          ),
                        GestureDetector(
                          onTap: () {
                            if (DownloadStatus.REQUEST != status) {
                              _onClick();
                            }
                            if (DownloadStatus.INITIAL == status) {
                              updateStatus(DownloadStatus.REQUEST, 0);
                            }
                          },
                          child: Container(
                            height: 41,
                            width: 111,
                            alignment: Alignment.center,
                            margin: EdgeInsets.only(top: 25, bottom: 18),
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(21)),
                              color: AppTheme.colors.themeColor,
                            ),
                            child: Text(
                              statusText,
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                  decoration: TextDecoration.none),
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
              Image.asset(
                "images/pic_n_Toupdate.png",
                height: 156,
                width: 271,
              ),
            ],
          )),
        ));
  }

  void _onClick() {
    if (Platform.isIOS) {
      _launchURL(widget.upInfo.url);
      return;
    }

    switch (status) {
      case DownloadStatus.PAUSE:
        FlutterDownloadPlugin.startTask(
            "app.apk", widget.upInfo.url, int.parse(AppConfig.appid));
        break;
      case DownloadStatus.INITIAL:
        FlutterDownloadPlugin.startTask(
            "app.apk", widget.upInfo.url, int.parse(AppConfig.appid));
        break;
      case DownloadStatus.DOWNLOADING: //暂停
        FlutterDownloadPlugin.pauseTask(
            "app.apk", widget.upInfo.url, int.parse(AppConfig.appid));
        updateStatus(DownloadStatus.PAUSE, curProgress);
        break;

      case DownloadStatus.OPEN: //打开
        break;
      case DownloadStatus.INSTALL: //安装
        FlutterDownloadPlugin.install("app.apk", widget.upInfo.url);
        break;
    }
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      print('Could not launch $url');
    }
  }
}

class UpdateDownListener implements DownloadListener {
  Function(int status, double progress) updateStatus;

  UpdateDownListener(this.updateStatus);

  @override
  void canceled() {
    // TODO: implement canceled
    updateStatus(DownloadStatus.INITIAL, 0);
  }

  @override
  void completed() {
    // TODO: implement completed
    updateStatus(DownloadStatus.INSTALL, 100);
  }

  @override
  void connected() {
    // TODO: implement connected
    updateStatus(DownloadStatus.DOWNLOADING, 0);
  }

  @override
  void error() {
    // TODO: implement error
    updateStatus(DownloadStatus.RETRY, 0);
  }

  @override
  int getGameId() {
    // TODO: implement getGameId
    return int.parse(AppConfig.appid);
  }

  @override
  void progress(currentOffset, totalLength) {
    // TODO: implement progress
    num curProgress = (currentOffset / totalLength) * 100;
    updateStatus(DownloadStatus.DOWNLOADING, curProgress);
    print("回调进度：" + curProgress.toString());
  }

  @override
  void retry() {
    // TODO: implement retry
    updateStatus(DownloadStatus.RETRY, 0);
  }

  @override
  void started() {
    // TODO: implement started
    updateStatus(DownloadStatus.DOWNLOADING, 0);
  }

  @override
  void update() {
    // TODO: implement update
  }

  @override
  void warn() {
    // TODO: implement warn
  }
}

class UpdateDownloadSign implements DownloadSignListener {
  Function(int status, double progress) updateStatus;

  UpdateDownloadSign(this.updateStatus);

  @override
  void onCompleted() {
    updateStatus(DownloadStatus.INSTALL, 100);
  }

  @override
  void onError() {
    updateStatus(DownloadStatus.RETRY, 0);
  }

  @override
  int onGetGameId() {
    return int.parse(AppConfig.iosAppid);
  }

  @override
  void onInstalled() {}

  @override
  void onPause(String msg) {
    updateStatus(DownloadStatus.PAUSE, 0);
  }

  @override
  void onUpdate() {}

  @override
  void onProgress(double progress, String speed) {
    updateStatus(DownloadStatus.DOWNLOADING, progress);
  }

  @override
  bool onShowHint(int clickId, Object tag, next) {}
}
